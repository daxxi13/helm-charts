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
helm.sh/chart: {{ include "threadfin.chart" . | quote }}
app.kubernetes.io/name: {{ include "threadfin.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end }}
{{/*
Selector labels
*/}}
{{- define "threadfin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "threadfin.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
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