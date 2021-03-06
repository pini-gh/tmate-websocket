# tmate-protocol.h

defmodule Tmate.ProtocolDefs.Define do
  defmacro define(name, value) do
    quote do: (defmacro unquote(name), do: unquote(value))
  end

  defmacro enum(_enum_name, values) do
    values |> Enum.with_index |> Enum.map(fn {name, index} ->
      quote do: (defmacro unquote(name), do: unquote(index))
    end)
  end
end

defmodule Tmate.ProtocolDefs do
  import __MODULE__.Define

  define tmate_max_message_size, (17*1024)

  enum tmate_ws_out_msg_types, [
    tmate_ws_daemon_out_msg,
    tmate_ws_snapshot,
  ]

  enum tmate_ws_in_msg_types, [
    tmate_ws_pane_keys,
    tmate_ws_exec_cmd,
    tmate_ws_resize,
  ]

  enum tmate_control_out_msg_types, [
    tmate_ctl_header,
    tmate_ctl_deamon_out_msg,
    tmate_ctl_snapshot,
    tmate_ctl_client_join,
    tmate_ctl_client_left,
    tmate_ctl_exec,
    tmate_ctl_latency,
  ]

  enum tmate_control_in_msg_types, [
    tmate_ctl_deamon_fwd_msg,
    tmate_ctl_request_snapshot,
    tmate_ctl_pane_keys,
    tmate_ctl_resize,
    tmate_ctl_exec_response,
    tmate_ctl_rename_session,
  ]

  enum tmate_daemon_out_msg_types, [
    tmate_out_header,
    tmate_out_sync_layout,
    tmate_out_pty_data,
    tmate_out_exec_cmd_str,
    tmate_out_failed_cmd,
    tmate_out_status,
    tmate_out_sync_copy_mode,
    tmate_out_write_copy_mode,
    tmate_out_fin,
    tmate_out_ready,
    tmate_out_reconnect,
    tmate_out_snapshot,
    tmate_out_exec_cmd,
    tmate_out_uname,
  ]

  enum tmate_daemon_in_msg_types, [
    tmate_in_notify,
    tmate_in_pane_key,
    tmate_in_resize,
    tmate_in_exec_cmd_str,
    tmate_in_set_env,
    tmate_in_ready,
    tmate_in_exec_cmd,
  ]
end
