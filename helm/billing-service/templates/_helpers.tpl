{{- define "billing-service.name" -}}
tracking-service
{{- end }}

{{- define "billing-service.fullname" -}}
{{ .Release.Name }}
{{- end }}