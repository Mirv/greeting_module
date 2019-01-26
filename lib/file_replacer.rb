# require_relative 'lib/file_helpers'
# require_relative 'lib/file_directories'

class Replacer
  # extends FileHelpers
  includes Searcher
  def initialize(directory, ignore = "", log_changes = false)
    @log_changes = log_changes
    @directory = directory
    @ignore = ignore
  end
  

  
  def dry_run(target = "")

    puts p
  end
  
  def replace(replacement)
  end
end

class Searcher
  # attr_reader :files
  # def initialize(directory)
  #   @files = get_file_list(define_path(directory))
  # end
  
  # def define_path(directory)
  #   rbfiles = File.join("**", directory, "*.rb")
  # end
  
  # def get_file_list(target_string)
  #   Dir.glob(target_string)
  # end
  
  # def count
  #   puts files.count
  # end
  
  # def relevant(string)
  #   @files.grep(string)
  # end
  
  # '' is search current dir
  def initialize(matches, directory = "", exclude_dirs = "", types = "", recursive = true)
    @matches = matches
    @directory = directory
    @types = joiner(include_file_types(types) || "")
    @exclude_dirs = joiner(excluder(exclude_dirs))
    @recursive = recursive
  end
  
  def run_matches
    if @recursive
      search = "grep -R #{@matches} #{@exclude_dirs.strip} #{@directory.strip}".strip
      system(search)
    end
  end
  
  # Requires parts of version 2
  # def include_file_types(target)
  #   splitter(target).map!{|t| "--include=*.#{t}" }
  # end
  
  def optionize(a_string = "foo, bar", x="exclude-dir")
    a_string.prepend(', ')  # otherwise last option in a_string is unchanged
    a_string.gsub(', ', " --#{x}=") << " "  # add space so not touching others
  end
  
  # Version 2
  # def excluder(target)
  #   splitter(target).map!{|t| "--exclude-dir=#{t}" }
  # end

  # def splitter(target)
  #   target.split(', ')
  # end
  
  # def joiner(target)
  #   target.join(" ")
  # end
end
Searcher.new("require_relative").run_matches
# puts Searcher.new('').files
# puts Searcher.new('').count
# puts Searcher.new('').relevant("load")

# Replacer.new('lib').dry_run