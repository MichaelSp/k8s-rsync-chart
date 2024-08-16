{{/*
Expand the name of the chart.
*/}}
{{- define "backup.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "backup.namespace" -}}
{{- if .Values.namespace -}}
{{- .Values.namespace }}
{{- else -}}
{{- default "backup" .Release.Namespace }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "backup.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backup.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for proxy
*/}}
{{- define "backup.labels.proxy" -}}
helm.sh/chart: {{ include "backup.chart" . }}
{{ include "backup.selectorLabels.proxy" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for proxy
*/}}
{{- define "backup.selectorLabels.proxy" -}}
app.kubernetes.io/name: {{ include "backup.name" . }}-proxy
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: proxy
{{- end }}



{{/*
Common labels for sender
*/}}
{{- define "backup.labels.sender" -}}
helm.sh/chart: {{ include "backup.chart" . }}
{{ include "backup.selectorLabels.sender" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "backup.selectorLabels.sender" -}}
app.kubernetes.io/name: {{ include "backup.name" . }}-sender
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: sender
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "backup.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "backup.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
