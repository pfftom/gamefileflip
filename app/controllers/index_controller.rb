class IndexController < ApplicationController
  def index
  end

  def uploadfile
    exported = params[:exported]
    full = params[:full]
    @path = "#{Rails.root}/public/upload"
    files = temp_save(exported, full)
    c = Cfile.new(files, @path)
    c.read_zip()
    c.create_new()
    
    response.headers['Content-Type'] = 'application/zip'
    response.headers["Content-Disposition"] = "attachment; filename=#{full.original_filename}".to_s
    send_file(files[1])
    #temp_delete(files)
    #redirect_to :back
  end

  private 

  def temp_save(export, full)
    epath = File.join(@path, export.original_filename)
    fpath = File.join(@path, full.original_filename)

    File.open(epath, "wb") { |f|
      f.write(export.read)  
    }
    File.open(fpath, "wb") { |f|
      f.write(full.read)
    }
    return [epath, fpath]
  end

  def temp_delete(files)
    File.delete(files[0])
    File.delete(files[1])
  end
end
