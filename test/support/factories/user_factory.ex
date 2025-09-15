defmodule Foedus.UserFactory do
  alias Foedus.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          email: Faker.Internet.email(),
          hashed_password: Bcrypt.hash_pwd_salt("password123")
        }
      end
    end
  end
end
