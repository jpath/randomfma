require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  def setup
    @pl = Playlist.new :genre_handle => "Blues",:limit => 1
    stub(@pl).tracks_xml {FakeXml}
  end

  test "Playlistmaker should generate a playlist \
  using the passed genre_handle" do
    assert_equal @pl.genre_handle, "Blues"
  end

  test "Playlist should know the FMA Api URL" do
    assert_equal  "http://freemusicarchive.org/api/get/tracks.xml?genre_handle=Blues&limit=1",@pl.api_url
  end

  test "Playlist should generate a list of track urls" do
    @pl.generate
    assert_instance_of Array, @pl.track_urls 
    assert_equal 1, @pl.track_urls.size
    assert_equal  "http://freemusicarchive.org/music/Pussyfinger/Chew_And_Swallow/_1347", 
      @pl.track_urls[0]
  end

  test "Playlist should generate a list of track names" do
    @pl.generate
    assert_instance_of Array, @pl.track_titles 
    assert_equal 1, @pl.track_titles.size
    assert_equal "!@#?!", @pl.track_titles[0]
  end

  test "Playlist should generate a list of track ids" do
    @pl.generate
    assert_instance_of Array, @pl.track_ids 
    assert_equal 1, @pl.track_ids.size
    assert_equal "14636", @pl.track_ids[0]
  end

# Why do ruby heredocs never fucking work?
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
