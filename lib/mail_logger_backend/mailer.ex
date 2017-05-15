defmodule MailLoggerBackend.Mailer do
  @moduledoc """
  """

  import Bamboo.Email

  use Bamboo.Mailer, otp_app: :mail_logger_backend

  def send_mail(body) do
    mail_subject = get_env(:mail_subject)
    mail_to = get_env(:mail_to)
    mail_from = get_env(:mail_from)
    new_email()
      |> to(mail_to)
      |> from(mail_from)
      |> subject(mail_subject)
      |> text_body(body)
      |> deliver_now
  end

  defp get_env(key, default \\ nil) do
    value = Application.get_env(:mail_logger_backend, key, default)
    Application.get_env(MailLoggerBackend, key, value)
  end

end
