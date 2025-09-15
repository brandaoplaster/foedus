defmodule Foedus.Factory do
  use ExMachina.Ecto, repo: Foedus.Repo

  use Foedus.UserFactory
  use Foedus.ContractTemplateFactory
  use Foedus.ContractorFactory
end
