defmodule MeriazardWeb.Live.ArrayTableLive do
  use MeriazardWeb, :live_view

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
        <%= for {value, index} <- Enum.with_index(@array) do %>
          <tr>
            <td><%= index %></td>
            <td><%= value %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, array: get_array_from_params([]))}
  end

  defp get_array_from_params(_params) do
    # ここで、paramsから配列を取得するロジックを実装してください。
    # この例では、仮に空のリストを返します。
    ["apple", "banana", "orange", "hoge"]
  end
end
