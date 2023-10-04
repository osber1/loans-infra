{{/* vim: set filetype=mustache: */}}

{{- define "microservice.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper image name
*/}}
{{- define "microservice.image" -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $image := default (include "microservice.name" $) .Values.image.name -}}
{{- $tag := .Values.image.tag | toString -}}
{{- printf "%s/%s:%s" $repositoryName $image $tag -}}
{{- end -}}

{{/* Basic labels */}}
{{- define "microservice.labels" }}
app: {{ include "microservice.name" . }}
{{- end -}}
