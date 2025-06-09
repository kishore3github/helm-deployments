{{/* 
    _helpers.tpl
    Common template helpers for deployment, service, and ingress
*/}}

{{- define "my-service.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "my-service.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "my-service.deploymentName" -}}
{{- include "my-service.fullname" . }}-deployment
{{- end -}}

{{- define "my-service.serviceName" -}}
{{- include "my-service.fullname" . }}-service
{{- end -}}

{{- define "my-service.ingressName" -}}
{{- include "my-service.fullname" . }}-ingress
{{- end -}}

{{- define "my-service.labels" -}}
app.kubernetes.io/name: {{ include "my-service.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "my-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end -}}