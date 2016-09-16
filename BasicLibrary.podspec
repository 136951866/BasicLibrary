Pod::Spec.new do |s|
  s.subspec 'Test' do |Test|
   Test.source_file = 'BasicLibrary/Pod/Classes/Test/*.{h,m}'
  end
end
