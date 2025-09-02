defmodule FoedusWeb.ContractTemplateLiveTest do
  use FoedusWeb.ConnCase

  import Phoenix.LiveViewTest
  import Foedus.ContractsFixtures

  @create_attrs %{title: "some title", content: "some content"}
  @update_attrs %{title: "some updated title", content: "some updated content"}
  @invalid_attrs %{title: nil, content: nil}

  defp create_contract_template(_) do
    contract_template = contract_template_fixture()
    %{contract_template: contract_template}
  end

  describe "Index" do
    setup [:create_contract_template]

    test "lists all contract_templates", %{conn: conn, contract_template: contract_template} do
      {:ok, _index_live, html} = live(conn, ~p"/contract_templates")

      assert html =~ "Listing Contract templates"
      assert html =~ contract_template.title
    end

    test "saves new contract_template", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/contract_templates")

      assert index_live |> element("a", "New Contract template") |> render_click() =~
               "New Contract template"

      assert_patch(index_live, ~p"/contract_templates/new")

      assert index_live
             |> form("#contract_template-form", contract_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contract_template-form", contract_template: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/contract_templates")

      html = render(index_live)
      assert html =~ "Contract template created successfully"
      assert html =~ "some title"
    end

    test "updates contract_template in listing", %{conn: conn, contract_template: contract_template} do
      {:ok, index_live, _html} = live(conn, ~p"/contract_templates")

      assert index_live |> element("#contract_templates-#{contract_template.id} a", "Edit") |> render_click() =~
               "Edit Contract template"

      assert_patch(index_live, ~p"/contract_templates/#{contract_template}/edit")

      assert index_live
             |> form("#contract_template-form", contract_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contract_template-form", contract_template: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/contract_templates")

      html = render(index_live)
      assert html =~ "Contract template updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes contract_template in listing", %{conn: conn, contract_template: contract_template} do
      {:ok, index_live, _html} = live(conn, ~p"/contract_templates")

      assert index_live |> element("#contract_templates-#{contract_template.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#contract_templates-#{contract_template.id}")
    end
  end

  describe "Show" do
    setup [:create_contract_template]

    test "displays contract_template", %{conn: conn, contract_template: contract_template} do
      {:ok, _show_live, html} = live(conn, ~p"/contract_templates/#{contract_template}")

      assert html =~ "Show Contract template"
      assert html =~ contract_template.title
    end

    test "updates contract_template within modal", %{conn: conn, contract_template: contract_template} do
      {:ok, show_live, _html} = live(conn, ~p"/contract_templates/#{contract_template}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Contract template"

      assert_patch(show_live, ~p"/contract_templates/#{contract_template}/show/edit")

      assert show_live
             |> form("#contract_template-form", contract_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#contract_template-form", contract_template: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/contract_templates/#{contract_template}")

      html = render(show_live)
      assert html =~ "Contract template updated successfully"
      assert html =~ "some updated title"
    end
  end
end
