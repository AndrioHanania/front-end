FROM node:16-alpine
WORKDIR /opt/frontend
COPY . .
RUN npm install
EXPOSE 8079
CMD ["npm", "start"]