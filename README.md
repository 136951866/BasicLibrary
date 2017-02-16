#用cocopod管理项目
##1.在git上开2个仓库
https://github.com/136951866/SpecsRepo 放配置文件
https://github.com/136951866/BasicLibrary 放源文件

##2.在本地创建2个文件夹SpecsRepo/ BasicLibrary（可自定义）
SpecsRepo 放配置文件
Specs－项目名称－版本－.podspec
BasicLibrary放源文件
项目名称－Pod－Classes（.m.h）/Assets(图片)－其他一些目录

##3.用ruby编写.podspec
Pod::Spec.new do |s|
s.name = 'Common'
s.version = '1.0.2'
s.summary = '一些公共的插件'
s.homepage = 'https://github.com/136951866/BasicLibrary.git'
s.license = 'MIT'
s.authors = {'Hank Zhang' => '136951866@qq.com'}
s.platform = :ios, '7.0'
s.source = {:git => 'https://github.com/136951866/BasicLibrary.git', :tag => s.version}
s.source_files = 'Common/Pod/Classes/*.{h,m}'
s.dependency 'MBProgressHUD'//依赖库
s.resource_bundles = {
'Common' => ['Pod/Assets/*.png']
}//资源路径
//更新下来分目录
s.subspec '其他目录' do |自定义|
自定义.source_files = 'Common/Pod/Classes/其他目录/*.{h,m}'
end
s.requires_arc = true
end

##4.把BasicLibrary打tag上传到git上要对应pod spec的SpecsRepo版本文件夹的版本
git add .
git commit -m "版本8"
git tag -m "version "版本" 版本
git push --tag
