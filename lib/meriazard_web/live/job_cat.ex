defmodule MeriazardWeb.JobCat do
  use Phoenix.LiveView

  def render(assigns) do
    MeriazardWeb.LiveView.render("job_cat.html", assigns)
  end

  def mount(_params, _session, socket ) do
    IO.puts 'calling mount'
    { :ok, assign( socket,
                   %{message: "[Init]", page_title: "Meriazard",
                   results: [], maxcnt: 0,
                   keyword: "elixir"} ) }
  end

  def handle_event( "submit", %{"keyword" => keyword }, socket) do
    send( self(), { :submit, keyword})
    { :noreply, assign(socket, message: "[Searching]", keyword: keyword)}
  end

  def handle_info( { :submit, keyword }, socket ) do
    IO.puts 'gottit.'
#    host = "https://connpass.com"
#    path_list = ["/api/v1/event/?",
#                 "ymd=#{query}&",
#                 "keyword=#{keyword}&",
#                 "count=50&",
#                 "order=2"]
#    path = Enum.join(path_list, "")
#    results = Json.get("#{host}", "#{path}")
#    maxcnt = results["results_available"]
#    events = results["events"]
    events = [
      %{ "url" => "hoge", "id" =>  1, "memo" =>  "test1", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  2, "memo" =>  "test2", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  3, "memo" =>  "test3", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  4, "memo" =>  "test4", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  5, "memo" =>  "test5", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  6, "memo" =>  "test6", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  7, "memo" =>  "test7", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  8, "memo" =>  "test8", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" =>  9, "memo" =>  "test9", "tag" => "shigotoneko", "started_at" => "2020/01/01"},
      %{ "url" => "hoge", "id" => 10, "memo" => "test10", "tag" => "",            "started_at" => "2020/01/01"}
    ]

    {:noreply, assign( socket,
                       message: "[Complete!!]",
                       results: events, maxcnt: 10 ) }
  end  

end