def create_log
    diff = `git diff`
    diff_stat = `git diff --numstat`
    timestamp = Time.now.getutc.to_i
    commit_hash = `git rev-parse HEAD`.strip
    branch = `git rev-parse --abbrev-ref HEAD`.strip
    if diff == ""
        diff = `git diff HEAD~1`
        diff_stat = `git diff HEAD~1 --numstat`
        commit_hash = `git rev-parse HEAD~1`.strip
    end
    log_file_name = "#{timestamp}_#{commit_hash}"
    f = File.new(".log_cs169/#{log_file_name}.txt", "w")
    f.write("#{branch}, #{Rails.env}\n")
    f.write(diff)
    f.write("\n--\n")
    f.write(diff_stat)
    f.close
end
# Check that logs directory is set up and if not, make a blank one
def check_dir
    if not Dir.exists?('.log_cs169')
        puts "got here"
        Dir.mkdir '.log_cs169'
    end
end

if Rails.env == "development"
    check_dir
    listener = Listen.to('', ignore: /\.log_cs169/) do |modified, added, removed|
        if modified != [] or added != [] or removed != []
           create_log 
        end
    end
    listener.ignore /db\/development/
    listener.ignore /db\/test/
    listener.ignore /db\/production/
    listener.start
elsif Rails.env == "test"
    check_dir
    create_log
end
