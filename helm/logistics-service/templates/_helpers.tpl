{{- define "tracking-service.name" -}}
tracking-service
{{- end }}

{{- define "tracking-service.fullname" -}}
{{ .Release.Name }}
{{- end }}