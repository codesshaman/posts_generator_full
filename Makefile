name = Posts Generator

NO_COLOR=\033[0m	# Color Reset
COLOR_OFF='\e[0m'       # Color Off
OK_COLOR=\033[32;01m	# Green Ok
ERROR_COLOR=\033[31;01m	# Error red
WARN_COLOR=\033[33;01m	# Warning yellow
RED='\e[1;31m'          # Red
GREEN='\e[1;32m'        # Green
YELLOW='\e[1;33m'       # Yellow
BLUE='\e[1;34m'         # Blue
PURPLE='\e[1;35m'       # Purple
CYAN='\e[1;36m'         # Cyan
WHITE='\e[1;37m'        # White
UCYAN='\e[4;36m'        # Cyan

all:
	@printf "Launch configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d back front postgres

help:
	@echo -e "$(OK_COLOR)==== All commands of ${name} configuration ====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)- make				: Launch configuration"
	@echo -e "$(WARN_COLOR)- make back			: Git pull backend changes"
	@echo -e "$(WARN_COLOR)- make bd			: Build database only"
	@echo -e "$(WARN_COLOR)- make build			: Building configuration"
	@echo -e "$(WARN_COLOR)- make conb			: Connect to the backend"
	@echo -e "$(WARN_COLOR)- make condb			: Connect to the database"
	@echo -e "$(WARN_COLOR)- make conf			: Connect to the frontend"
	@echo -e "$(WARN_COLOR)- make dd			: Down database"
	@echo -e "$(WARN_COLOR)- make down			: Stopping configuration"
	@echo -e "$(WARN_COLOR)- make front			: Git pull frontend changes"
	@echo -e "$(WARN_COLOR)- make full			: Launch full configuration"
	@echo -e "$(WARN_COLOR)- make fullbuild		: Building full configuration"
	@echo -e "$(WARN_COLOR)- make push			: Push changes to the github"
	@echo -e "$(WARN_COLOR)- make re			: Rebuild configuration"
	@echo -e "$(WARN_COLOR)- make red			: Rebuild database"
	@echo -e "$(WARN_COLOR)- make refl			: Rebuild flask configuration"
	@echo -e "$(WARN_COLOR)- make repa			: Rebuild pgadmin configuration"
	@echo -e "$(WARN_COLOR)- make reps			: Rebuild postgres configuration"
	@echo -e "$(WARN_COLOR)- make ps			: View configuration"
	@echo -e "$(WARN_COLOR)- make clean			: Cleaning configuration$(NO_COLOR)"

back:
	@bash scripts/back.sh

build:
	@printf "$(YELLOW)==== Building configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --build back front postgres

bd:
	@printf "$(YELLOW)==== Building ${name} database... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --build postgres

conb:
	@printf "$(OK_COLOR)==== Connect to ${name} backend... ====$(NO_COLOR)\n"
	@docker exec -it --user postgres back sh

condb:
	@printf "$(OK_COLOR)==== Connect to ${name} database... ====$(NO_COLOR)\n"
	@docker exec -it --user postgres postgres psql

conf:
	@printf "$(OK_COLOR)==== Connect to ${name} backend... ====$(NO_COLOR)\n"
	@docker exec -it --user postgres front sh

dd:
	@printf "$(ERROR_COLOR)==== Stopping database ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down

dd:
	@printf "$(ERROR_COLOR)==== Stopping database ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down postgres

down:
	@printf "$(ERROR_COLOR)==== Stopping configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down

env:
	@printf "$(ERROR_COLOR)==== Create environment file for ${name}... ====$(NO_COLOR)\n"
	@if [ -f .env ]; then \
		rm .env; \
	fi; \
	cp .env.example .env

front:
	@bash scripts/front.sh

full:
	@printf "Launch full configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d

fullbuild:
	@printf "$(YELLOW)==== Building full configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --build

git:
	@bash scripts/gituser.sh

push:
	@bash scripts/push.sh

re:
	@printf "$(OK_COLOR)==== Rebuild configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build

red:
	@printf "$(OK_COLOR)==== Rebuild ${name} database... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build postgres

refl:
	@printf "$(OK_COLOR)==== Rebuild postgres... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build flask

reps:
	@printf "$(OK_COLOR)==== Rebuild postgres... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build postgres

repa:
	@printf "$(OK_COLOR)==== Rebuild pgadmin... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build pgadmin

ps:
	@printf "$(BLUE)==== View configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml ps

clean: down
	@printf "$(ERROR_COLOR)==== Cleaning configuration ${name}... ====$(NO_COLOR)\n"
	@yes | docker system prune -a

fclean:
	@printf "$(ERROR_COLOR)==== Total clean of all configurations docker ====$(NO_COLOR)\n"
	# Uncommit if necessary:
	# @docker stop $$(docker ps -qa)
	# @docker system prune --all --force --volumes
	# @docker network prune --force
	# @docker volume prune --force

.PHONY	: all back bd front help build dd down re red refl repa reps ps clean fclean
