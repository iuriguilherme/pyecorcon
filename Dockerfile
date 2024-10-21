FROM python:3.11-slim
# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

# Install pipenv and compilation dependencies
RUN pip install pipenv
RUN apt-get update && apt-get install -y --no-install-recommends gcc

RUN useradd --create-home appuser
USER appuser
WORKDIR /home/appuser

COPY --chown=appuser . .
RUN PIPENV_SKIP_LOCK=true PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy
ENV PATH="/.venv/bin:$PATH"

EXPOSE 8080
# Run the application
ENTRYPOINT ["pipenv", "run", "prod"]
CMD []
