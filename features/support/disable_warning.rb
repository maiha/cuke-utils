module DisableWarning
  def warn(*)
  end
end

HTML::Document.send :include, DisableWarning
