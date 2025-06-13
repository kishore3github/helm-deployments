{{/* 
    _helpers.tpl
    Common template helpers for deployment, service, and ingress
*/}}

{{- define "add-team.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "add-team.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "add-team.deploymentName" -}}
{{- include "add-team.fullname" . }}-deployment
{{- end -}}

{{- define "add-team.serviceName" -}}
{{- include "add-team.fullname" . }}-service
{{- end -}}

{{- define "add-team.ingressName" -}}
{{- include "add-team.fullname" . }}-ingress
{{- end -}}

{{- define "add-team.labels" -}}
app.kubernetes.io/name: {{ include "add-team.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "add-team.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end -}}