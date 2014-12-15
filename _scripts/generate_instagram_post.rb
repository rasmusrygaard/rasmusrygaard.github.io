files =
  Dir.glob('./_assets/images/*.jpg').
  map { |filename| filename.split('/')[-1] }.
  map { |filename| filename.match(/(?<year>\d{4})
                                      (?<month>\d{2})
                                      (?<day>\d{2})_
                                      (?<title>[^.]+)
                                      .jpg/x) }.
  compact

files.each do |photo|
  dashed_date = "#{ photo[:year] }-#{ photo[:month] }-#{ photo[:day] }"
  spaced_title = photo[:title].tr('_', ' ')

  filename = "_posts/#{ dashed_date }-#{ photo[:title].tr('_', '-') }.markdown"
  next if Dir.exists?(filename)

  File.open(filename, 'w') do |f|
    [
      "---",
      "layout: post",
      "title: \"#{ spaced_title }\"",
      "date: #{ dashed_date } 12:00:00",
      "categories: instagram",
      "cover: #{ photo.string }",
      "---",
    ].each do |line|
      f.write("#{ line }\n")
    end
  end
end
