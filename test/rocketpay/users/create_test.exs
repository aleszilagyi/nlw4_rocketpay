defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Alexandre",
        password: "12345678",
        nickname: "ale",
        email: "ale@email.com",
        age: 29
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Alexandre", age: 29, id: ^user_id} = user
    end

    test "when there's invalid params, returns an user" do
      params = %{
        name: "Alexandre",
        password: "123456",
        nickname: "ale",
        email: "ale@email.com",
        age: 29
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        password: ["should be at least 8 character(s)"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
