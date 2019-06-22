#!/bin/sh

"sourcery" --sources ./Weather/ \
--sources ./WeatherTests/SourceryMocks/SourceryMocks.swift \
--templates ./scripts/Sourcery/AutoMockable.stencil \
--output ./WeatherTests/SourceryMocks/AutoMockable.generated.swift
