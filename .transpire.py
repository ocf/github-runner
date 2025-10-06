from pathlib import Path

from transpire.resources import Secret, Deployment
from transpire.types import Image
from transpire.utils import get_image_tag

name = "github-runner"

def objects():
    yield Secret(
        name=name,
        string_data={
            "GITHUB_PAT": "",
        }
    ).build()

    deployment = Deployment(
        name=name,
        ports=[443],
        image=get_image_tag(name),
    )
    deployment.pod_spec().with_secret_env(name)
    yield deployment.build()

def images():
    yield Image(name=name, path=Path("/"), registry="ghcr")
