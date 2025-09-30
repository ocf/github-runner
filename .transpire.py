from pathlib import Path

from transpire.resources import Secret, Deployment
from transpire.types import Image
from transpire.utils import get_image_tag

name = "github-runner"

def objects():
    yield Secret(
        name=name,
        string_data={
            "RUNNER_TOKEN": "",
        }
    ).build()

    deployment = Deployment(
        name=name,
        image=get_image_tag(name),
    )
    deployment.with_secret_env(name)
    yield deployment.build()

def images():
    yield Image(name=name, path=Path("/"), registry="ghcr")
