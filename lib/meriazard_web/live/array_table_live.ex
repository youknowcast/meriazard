defmodule MeriazardWeb.Live.ArrayTableLive do
  use MeriazardWeb, :live_view

  @page_size 50

  @impl true
  def render(assigns) do
    ~L"""
    <table>
      <thead>
        <tr>
          <th>Index</th>
          <th>Value</th>
        </tr>
      </thead>
      <tbody>
        <%= for {value, index} <- Enum.with_index(@array) |> Enum.slice((@page - 1) * @page_size, @page_size) do %>
          <tr>
            <td><%= index %></td>
            <td><%= value %></td>
          </tr>
        <% end %>
      </tbody>
    </table>

    <div>
      <%= if @page > 1 do %>
        <button phx-click="paginate" phx-value-page="<%= @page - 1 %>">Previous</button>
      <% end %>

      <span>Page <%= @page %></span>

      <%= if Enum.count(@array) > @page * @page_size do %>
        <button phx-click="paginate" phx-value-page="<%= @page + 1 %>">Next</button>
      <% end %>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :array, []) |> assign(:page, 1) |> assign(:page_size, @page_size)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = Map.get(params, "page", "1") |> String.to_integer()
    {:noreply, assign(socket, :array, get_array_from_params(params)) |> assign(:page, page)}
  end

  def handle_event("paginate", %{"page" => page}, socket) do
    {:noreply, assign(socket, :page, String.to_integer(page))}
  end

  defp get_array_from_params(_params) do
    Enum.to_list(1..500)
    |> Enum.map(fn x -> "hoge" end)
  end
end
