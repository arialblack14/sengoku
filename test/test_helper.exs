ExUnit.start()
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, SengokuWeb.Endpoint.url)
Application.put_env(:wallaby, :screenshot_on_failure, true)
Application.put_env(:wallaby, :js_errors, false)
