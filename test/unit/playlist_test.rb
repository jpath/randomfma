require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  def setup
    @pl = Playlist.new :genre_handle => "Blues",:limit => 1
    @doc = stub(Object.new).body_str {FakeXml}
    stub(Curl::Easy).perform(@pl.api_url({:limit => 1})) {@doc}
  end

  test "Playlistmaker should generate a playlist \
  using the passed genre_handle" do
    assert_equal @pl.genre_handle, "Blues"
  end

  test "Playlist should know the FMA Api URL" do
    assert_equal  "http://freemusicarchive.org/api/get/tracks.xml?genre_handle=Blues&limit=1",@pl.api_url(:limit => 1)
  end

  def setup_for_generator_test
    stub(Kernel).rand(100) {3}
    stub(@pl).limit {1}
    stub(@pl).pages_for_genre {100}
    mock(Curl::Easy).perform.with_any_args {@doc}
  end

  test "Playlist should have associated track(s)" do 
    assert_respond_to(@pl, :tracks)
  end

  test "Playlist should generate a list of track urls" do
    setup_for_generator_test
    @pl.generate
    assert_equal  "http://freemusicarchive.org/music/Pussyfinger/Chew_And_Swallow/_1347", 
      @pl.tracks.first.url
  end

  test "Playlist should generate a list of track names" do
    setup_for_generator_test
    @pl.generate
    assert_equal "!@#?!", @pl.tracks.first.title
  end

  test "Playlist should generate a list of fma track ids" do
    setup_for_generator_test
    @pl.generate
    assert_equal "14636", @pl.tracks.first.fma_id
  end

  test "Playlist should store the album url per track" do
    setup_for_generator_test
    @pl.generate
    assert_equal "http://freemusicarchive.org/music/Pussyfinger/Chew_And_Swallow/", @pl.tracks.first.album_url
  end

  test "Playlist should store the artist url per track" do
    setup_for_generator_test
    @pl.generate
    assert_equal "http://freemusicarchive.org/music/Pussyfinger/", @pl.tracks.first.artist_url
  end

  test "Playlist should store the artist name per track" do
    setup_for_generator_test
    @pl.generate
    assert_equal "Pussyfinger", @pl.tracks.first.artist
  end

  test "Playlist should store the album name per track" do
    setup_for_generator_test
    @pl.generate
    assert_equal "Chew And Swallow", @pl.tracks.first.album
  end

  test "Playlist should generate player embed code for a track, given it's id" do
    assert_equal FakeEmbedHtml, Playlist.embedded_player_for_track("14636")
  end

  test "Playlist should get the total number of pages for a genre" do
    assert_equal 6285, @pl.pages_for_genre
  end

  test "API URL generator should add arbitrary params to query string" do
    assert_equal  "http://freemusicarchive.org/api/get/tracks.xml?genre_handle=Blues&page=4&limit=1",
      @pl.api_url({:limit => 1, :page => 4})
  end

  FakeEmbedHtml = Playlist::EmbedHtml % ["14636", "14636"]
  FakeXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<data>
  <title>Free Music Archive - Tracks</title>
  <message></message>
  <errors/>
  <total>6285</total>
  <total_pages>6285</total_pages>
  <page>1</page>
  <limit>1</limit>
  <dataset>
    <value>
      <track_id>14636</track_id>
      <track_title>!@#?!</track_title>
      <track_url>http://freemusicarchive.org/music/Pussyfinger/Chew_And_Swallow/_1347</track_url>
      <track_image_file/>
      <artist_id>3446</artist_id>
      <artist_name>Pussyfinger</artist_name>
      <artist_url>http://freemusicarchive.org/music/Pussyfinger/</artist_url>
      <album_id>3391</album_id>
      <album_title>Chew And Swallow</album_title>
      <album_url>http://freemusicarchive.org/music/Pussyfinger/Chew_And_Swallow/</album_url>
      <track_language_code>en</track_language_code>
      <track_duration>00:21</track_duration>
      <track_number>9</track_number>
      <track_disc_number>1</track_disc_number>
      <track_explicit></track_explicit>
      <track_explicit_notes/>
      <track_copyright_c/>
      <track_copyright_p/>
      <track_composer/>
      <track_lyricist/>
      <track_publisher/>
      <track_instrumental>0</track_instrumental>
      <track_information/>
      <track_date_recorded/>
      <track_comments>0</track_comments>
      <track_favorites>1</track_favorites>
      <track_listens>308</track_listens>
      <track_interest>137</track_interest>
      <track_date_created>6/08/2009 11:53:01 AM</track_date_created>
      <track_genres/>
      <artist_images>
        <value>
          <genre_id>15</genre_id>
          <genre_title>Electronic</genre_title>
          <genre_url>http://freemusicarchive.org/genre/Electronic/</genre_url>
        </value>
        <value>
          <genre_id>41</genre_id>
          <genre_title>Electroacoustic</genre_title>
          <genre_url>http://freemusicarchive.org/genre/Electroacoustic/</genre_url>
        </value>
      </artist_images>
    </value>
  </dataset>
</data>"

end
