######################################################################
# Autosave
#
#  A cucumber plugin to save visited page automatically
#
# Usage:
#   Save this file as
#     features/support/autosave.rb
#
#   Then all visited pages are automatically stored into
#     RAILS_ROOT/tmp/webrat/*.html
#
# Author:
#   maiha <maiha@wota.jp>
#

require 'pathname'

module AutoSaveVisitedPage
  def visit(*args)
    val = super
    auto_save
    return val
  end

  def auto_save
    path = AutoSaveVisitedPage.auto_save_path
    path.open("w+") {|f| f.print response_body}
    auto_save_update_latest(path)
  end

  def auto_save_update_latest(path)
    latest = auto_save_path(:latest)
    latest.unlink if latest.exist?
    Dir.chdir(path.parent) do
      FileUtils.ln_s(path.basename, latest.basename)
    end
  end

  def auto_save_base
    Pathname(File.dirname(__FILE__)) + ".." + ".." + "tmp" + "webrat"
  end

  def auto_save_path(target = nil)
    base = auto_save_base.cleanpath
    base.mkpath
    base +
      case target
      when :latest then "latest.html"
      when :dir    then ''
      else
        max = Dir["#{base}/*.html"].grep(%r{/(\d+)\.html$}){$1.to_i}.max || 0
        "#{max+1}.html"
      end
  end

  def self.init
    path = auto_save_path(:dir)
    if path.exist?
      puts "[AutoSave] Cleaning #{path} (#{Time.now})"
      FileUtils.rm_rf path
    end
  end

  module_function :auto_save_path
  module_function :auto_save_base
end

AutoSaveVisitedPage.init
World(AutoSaveVisitedPage)
