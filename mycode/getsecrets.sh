#!/bin/bash

kube_context=(
"arn:aws:eks:us-east-1:awsacct:cluster/bp-demoeast-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bp-soaktesteast-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bp-testeast-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bp-dev-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bo-bsoaktest-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bo-btest-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bo-develop-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bp-aaatest-eks-cluster"
"arn:aws:eks:us-east-1:awsacct:cluster/bo-devops-eks-cluster"
)

function prod(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bp-prod-eks-cluster"
  )
  getallenvsecrets
}

function brillprod(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bp-brillprod-eks-cluster"
  )
  getallenvsecrets
}

function dev(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bp-dev-eks-cluster"
  )
  getallenvsecrets
}
-
function demoeast(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bp-demoeast-eks-cluster"
  )
  getallenvsecrets
}

function testeast(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bp-testeast-eks-cluster"
  )
  getallenvsecrets
}

function soaktesteast(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bp-soaktesteast-eks-cluster"
  )
  getallenvsecrets
}

function aaatest(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bp-aaatest-eks-cluster"
  )
  getallenvsecrets
}

function develop(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bo-develop-eks-cluster"
  )
  getallenvsecrets
}

function btest(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bo-btest-eks-cluster"
  )
  getallenvsecrets
}

function bsoaktest(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bo-bsoaktest-eks-cluster"
  )
  getallenvsecrets
}

function devops(){
  clear
  kube_context=(
  "arn:aws:eks:us-east-1:awsacct:cluster/bo-devops-eks-cluster"
  )
  getallenvsecrets
}

function getallenvsecrets(){
  clear
  rm -rf ./temp 2>/dev/null
  mkdir ./temp

  for each_context in ${kube_context[@]}
  do
    /usr/local/bin/kubectl config use-context ${each_context} >/dev/null 2>&1
    echo "context set on ${each_context}"
    environment=`echo ${each_context} | cut -d '-' -f 4`
    echo "Environment Chosen from Cluster:"${environment}
    rm -rf ${environment} 2>/dev/null
    mkdir ${environment}
    kubectl get secrets -n dev | cut -d" " -f1  | grep -v NAME | grep ^bpe- > ./temp/dev-secrets-${environment}
    for each_secret in `cat temp/dev-secrets-${environment}`
      do
        echo "Writing secret locally," ${environment}"/"${each_secret}".yaml"
        kubectl get secret ${each_secret} -n dev -o yaml > ${environment}/${each_secret}.yaml; done
      done
}

# Write the case statement to print details for
while true
do
  clear
  echo "Welcome to kubernetes secret autowriter"
  echo "---------------------------------------"
  echo "Enter below choices"
  echo
  echo "all"
  echo
  echo "dev"
  echo "demoeast"
  echo "testeast"
  echo "soaktesteast"
  echo "aaatest"
  echo
  echo "develop"
  echo "bsoaktest"
  echo "btest"
  echo "devops"
  echo
  echo
  echo "exit"

  echo
  read -p "Enter you choice: " ch
  case ${ch} in
    all) echo "retriving all the secrets from all environments"
         getallenvsecrets;;
    dev) dev;;
    demoeast) demoeast;;
    testeast) testeast;;
    soaktesteast) soaktesteast;;
    aaatest) aaatest;;
    develop) develop;;
    bsoaktest) bsoaktest;;
    btest) btest;;
    devops) devops;;
    exit)echo "Exiting..Good bye .."
         exit;;
  esac
done

