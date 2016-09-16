Pod::Spec.new do |s|
    s.name         = 'BasicLibrary'
    s.version      = '10.0.0'
    s.summary      = 'BasicLibrary'
    s.homepage     = 'https://github.com/136951866/BasicLibrary.git'
    s.license      = 'MIT'
    s.authors      = {'Hank Zhang' => '136951866@qq.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/136951866/BasicLibrary.git', :tag => s.version}
    s.source_files = 'Pod/Classes/*.{h,m}'
    s.requires_arc = true
end
