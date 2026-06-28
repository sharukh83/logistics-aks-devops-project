{{- define "notification-service.name" -}}
notification-service
{{- end }}

{{- define "notification-service.fullname" -}}
{{ .Release.Name }}
{{- end }}