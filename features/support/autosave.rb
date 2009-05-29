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

module AutoSaveVisitedPage
  def visit(*args)
    returning(super) do
      path = AutoSaveVisitedPage.auto_save_path
      path.open("w+") {|f| f.print response_body}
      auto_save_update_latest(path)
    end
  end

  def auto_save_update_latest(path)
    latest = auto_save_path(:latest)
    latest.unlink if latest.exist?
    FileUtils.ln_s(path, latest)
  end

  def auto_save_path(target = nil)
    (base = Pathname(RAILS_ROOT) + "tmp" + "webrat").mkpath
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
      puts "[AutoSave] Cleaning #{path}"
      FileUtils.rm_rf path
    end
  end

  module_function :auto_save_path
end

AutoSaveVisitedPage.init
World(AutoSaveVisitedPage)
