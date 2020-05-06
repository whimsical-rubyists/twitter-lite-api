# Contributing
When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

## PR Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a build.
2. Update the README.md with details of changes to the interface, this includes new environment variables, exposed ports, useful file locations and container parameters. 
- Any new environment variables should be updated in the `.env.template` file
3. Update Swagger documentation if any changes to api endpoints were done
4. You may merge the Pull Request in once other developers, or if you do not have permission to do that, you may request the second reviewer to merge it for you

## Updating Swager Documentation
1. To create Swagger integration specs run the following commands, this assumes controller name is `my_controller.rb`
  ```bash
    rails generate rspec:swagger API::V1::MyController
  ```
  Alternatively, refer to the [rswag](https://github.com/rswag/rswag) documentation. There's an example spec that can guide you.

2. If the integration test for the controller you changed already exist just add the tests for the cases you added.

3. Generate the Swagger JSON file(S)
  ```bash
  rake rswag:spec:swaggerize
  ```

4. Check out the docs generated at `/api-docs`