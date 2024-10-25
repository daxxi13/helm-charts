{{/*
Generate the full name of the resource based on the release name and the chart name.
*/}}
{{- define "threadfin.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
