import { aws_lambda as lambda, Duration } from 'aws-cdk-lib';

import { CdkStack } from '../cdk-stack';
import { StackProps } from '../stack-props';

import { useBuildIamRoleForLambda } from '../utils/useBuildIamRoleForLambda';

import { useCapitalize } from '../utils/useCapitalize';

export const buildFetchRecentEpisodeLambda = (stack: CdkStack, props: StackProps) => {
  const { capitalize } = useCapitalize();
  const { buildIamRoleForLambda } = useBuildIamRoleForLambda();

  const iamRole = buildIamRoleForLambda(stack, props, `IamRoleForFetchRecentEpisodeLambda${capitalize(props.stage)}`);

  return new lambda.DockerImageFunction(stack, `FetchRecentEpisodeLambda${capitalize(props.stage)}`, {
    functionName: `FetchRecentEpisodeLambda${capitalize(props.stage)}`,
    code: lambda.DockerImageCode.fromImageAsset('./apps/y2bot', {
      cmd: ['app.App::FetchRecentEpisodeHandler.process'],
      buildArgs: {
        '--platform': 'linux/amd64',
      },
    }),
    timeout: Duration.seconds(30),
    memorySize: 128,
    role: iamRole,
    environment: {
      ENV: props.stage,
    },
  });
};
