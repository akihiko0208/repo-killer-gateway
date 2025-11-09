#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
MANI_DIR="$(cd "${SCRIPT_DIR}/.."; pwd -P)"

branch="$(git -C "${MANI_DIR}" branch --show-current 2>/dev/null || true)"
if [ -z "${branch}" ]; then
  branch="$(git -C "${MANI_DIR}" branch --no-color | sed -n 's/^\* //p' || true)"
fi
echo "[INFO] branch name in repo-killer-gateway : ${branch}"

repo init \
  -u ${SCRIPT_DIR}/../ \
  -b "${branch}" \
  -m default.xml \
  --repo-url=https://github.com/GerritCodeReview/git-repo \
  --repo-rev=stable \
  --no-clone-bundle

repo sync -j8
