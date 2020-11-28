require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
#Webサーバを起動した状態で/taskというURLを送信するとtask.html.erbファイルを表示する
server.mount('/task', WEBrick::HTTPServlet::ERBHandler, 'task.html.erb')
server.mount('/give_for.cgi', WEBrick::HTTPServlet::CGIHandler, 'give_for.rb')
server.mount('/quality.cgi', WEBrick::HTTPServlet::CGIHandler, 'quality.rb')
server.start
