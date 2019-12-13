group :default do
  guard 'rake', :task => 'default' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :resources do
  guard 'rake', :task => 'resources' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :specials do
  guard 'rake', :task => 'specials' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :game do
  guard 'rake', :task => 'all' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :special_backs do
  guard 'rake', :task => 'special_backs' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :resource_backs do
  guard 'rake', :task => 'resource_backs' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :ladders do
  guard 'rake', :task => 'ladders' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :tree do
  guard 'rake', :task => 'tree' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{img/.*}
  end
end

group :faces do
  guard 'rake', :task => 'faces' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml$}
    watch %r{img/.*}
  end
end

group :rules do
  guard 'rake', :task => 'rules' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
    watch %r{.*\.md$}
    watch %r{.*\.svg$}
    watch %r{.*\.css$}
    watch %r{img/.*}
  end
end

def watch_squibfiles(cxt)
  cxt.watch %r{.*\.xlsx$}
  cxt.watch %r{.*\.rb$}
  cxt.watch %r{.*\.yml}
  cxt.watch %r{img/.*}
end

group :bundle do
  guard 'rake', :task => 'bundle' do
    watch_squibfiles(self)
  end
end
