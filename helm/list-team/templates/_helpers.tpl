{{/* 
    _helpers.tpl
    Common template helpers for deployment, service, and ingress
*/}}

{{- define "list-team.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "list-team.deploymentName" -}}
{{- include "list-team.fullname" . }}-deployment
{{- end -}}

{{- define "list-team.serviceName" -}}
{{- include "list-team.fullname" . }}-service
{{- end -}}

{{- define "list-team.ingressName" -}}
{{- include "list-team.fullname" . }}-ingress
{{- end -}}

{{- define "list-team.labels" -}}
app.kubernetes.io/name: {{ include "list-team.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}