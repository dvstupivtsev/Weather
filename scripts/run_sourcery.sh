#!/bin/sh

if [[ -z "${PODS_ROOT}" ]]; then
  PODS_ROOT="Pods"
fi

"$PODS_ROOT/Sourcery/bin/sourcery" --sources ./Weather/ \
                                   --sources ./WeatherTests/SourceryMocks/SourceryMocks.swift \
                                   --templates ./Templates/Sourcery/AutoMockable.stencil \
                                   --output ./WeatherTests/SourceryMocks/AutoMockable.generated.swift
