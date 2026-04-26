#!/bin/bash
# run.sh — The Human Capitalist Content Pipeline
# Usage: ./run.sh [guest-slug]
# Example: ./run.sh elyse-ryan

if [ -z "$1" ]; then
  echo "Error: Please provide a guest slug."
  echo "Usage: ./run.sh [guest-slug]"
  echo "Example: ./run.sh elyse-ryan"
  exit 1
fi

SLUG=$1
TRANSCRIPT="episodes/$SLUG/transcript.txt"

if [ ! -f "$TRANSCRIPT" ]; then
  echo "Error: Transcript not found at $TRANSCRIPT"
  echo "Drop your transcript.txt file in episodes/$SLUG/ and try again."
  exit 1
fi

echo "🎙️  The Human Capitalist Content Pipeline"
echo "Episode: $SLUG"
echo "Transcript: $TRANSCRIPT"
echo ""
echo "Starting pipeline..."
echo ""

claude "Run the full Human Capitalist content pipeline for the episode at $TRANSCRIPT. Guest slug is $SLUG. Follow all steps in CLAUDE.md: analyze the transcript, run the blog writer agent first, then run the YouTube meta, social content, and thumbnail brief agents in parallel, then run the quality gate. Surface the quality report summary when done."
