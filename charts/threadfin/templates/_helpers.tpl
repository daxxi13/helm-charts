{{/*
Generate the full name of the resource based on the release name and the chart name.
*/}}
{{- define "threadfin.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "threadfin.labels" -}}
helm.sh/chart: {{ include "threadfin.chart" . }}
app.kubernetes.io/name: {{ include "threadfin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "threadfin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "threadfin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Chart name and version
*/}}
{{- define "threadfin.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{/*
Return the chart name
*/}}
{{- define "threadfin.name" -}}
{{ .Chart.Name }}
{{- end }}