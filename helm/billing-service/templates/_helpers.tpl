{{- define "billing-service.name" -}}
billing-service
{{- end }}

{{- define "billing-service.fullname" -}}
{{ .Release.Name }}
{{- end }}