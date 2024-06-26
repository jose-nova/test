defmodule UkioWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use UkioWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    case Enum.find_value(changeset.errors, fn {field, message} ->
      if field == :apartment_unavailable do
        :apartment_unavailable
      end
    end) do
      :apartment_unavailable ->
        conn
        |> put_status(:unauthorized)
        |> put_view(html: UkioWeb.ErrorHTML, json: UkioWeb.ErrorJSON)
        |> render(:"401")
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: UkioWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
      end
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: UkioWeb.ErrorHTML, json: UkioWeb.ErrorJSON)
    |> render(:"404")
  end
end
