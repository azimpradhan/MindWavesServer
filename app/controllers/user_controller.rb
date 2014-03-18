class UserController < ApplicationController
  require 'fileutils'


  def create
    puts "post request was made!"
    puts params
    user = User.where(:udid => params[:udid]).first_or_create!
    user.avatar_id = params[:avatar_id]
    user.lat = params[:lat]
    user.long = params[:long]
    user.udid = params[:udid]

    #upload sound here
    #"soundfile"=>#<ActionDispatch::Http::UploadedFile:0x007fd5751e20d8 @original_filename="stuff.wav", @content_type="audio/wav", @headers="Content-Disposition: form-data; name=\"soundfile\"; filename=\"stuff.wav\"\r\nContent-Type: audio/wav\r\n", @tempfile=#<File:/var/folders/jp/_6cbjh9112j_6fl8482n7zj80000gn/T/RackMultipart20140313-72687-1xugqvk>>}
    tmp = params[:soundfile].tempfile
    file = File.join("public/sound", params[:udid] + ".wav")
    FileUtils.cp tmp.path, file


    user.sound_filename = params[:udid] + ".wav"
    user.save!
    render :nothing => true
  end

  def refresh_with_new_users
    current_user = User.find_by_udid(params[:udid])
    if !current_user.nil?
      users_viewed = current_user.users_viewed
      new_users = (User.all - users_viewed) - [current_user]
      new_users.push(users_viewed)
      new_users.flatten!
      new_users.unshift(current_user)
    else
      new_users = User.all[0..2]
    end
    puts new_users[0..3].inspect
    render :json => new_users[0..3]
  end

  def record_view
    puts params
    source_user = User.find_by_udid(params[:source_udid])
    dest_user = User.find_by_udid(params[:dest_udid])


    if (source_user.nil? or dest_user.nil?)
      #error code
      render :nothing => true, :status => 403
    end
    puts dest_user.inspect
    u_v = UserView.where(:source_user_id => source_user.id, :dest_user_id => dest_user.id).first_or_create
    u_v.updated_at = DateTime.now
    u_v.save!
    render :nothing => true
  end


end
