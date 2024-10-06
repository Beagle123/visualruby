module VR

  def VR.copy_recursively(from, out_dir)
    Find.find(from) do |path|
      next if path == from
      rel_path = path.gsub(from, "")
      if File.directory?(path) 
        FileUtils.makedirs(out_dir + rel_path)   
      else
        if not File.directory?(out_dir + File.dirname(rel_path))
          FileUtils.makedirs(out_dir + File.dirname(rel_path))
        end
        FileUtils.copy(path, out_dir + rel_path)
      end
    end
  end

end


def vr_project?(path)
  File.exist?( File.join(path.to_s, VR_ENV::SETTINGS_FILE))
end
