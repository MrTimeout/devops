#!/bin/bash
# Valid placeholders for the Go template are listed below:
#          - .ID           - Container ID.
#          - .Image        - Image ID.
#          - .Command      - Quoted command.
#          - .CreatedAt    - Time when the container was created.
#          - .RunningFor   - Elapsed time since the container was started.
#          - .Ports        - Exposed ports.
#          - .Status       - Container status.
#          - .Size         - Container disk size.
#          - .Names        - Container names.
#          - .Labels       - All labels assigned to the container.
#          - .Label        - Value of a specific label for this container.
#                            For example '{{.Label "com.docker.swarm.cpu"}}'.
#          - .Mounts       - Names of the volumes mounted in this container.
#          - .Networks     - Names of the networks attached to this container.

docker system info --format "{{json .}}" | jq .

docker system info --format "{{.KernelVersion}}"

docker container ls --all --format="{{.ID}} {{.Image}} {{.Command}} {{.CreatedAt}} {{.RunningFor}} {{.Ports}} {{.Status}} {{.Size}} {{.Names}} {{.Labels}} {{.Mounts}} {{.Networks}}"