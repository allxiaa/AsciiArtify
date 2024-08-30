#!/bin/bash

# Define command-line arguments


PLUGIN_VERSION="v0.0.1"
kubeplugin_NAMESPACE=""


print_plugin_version() {
    echo "${PLUGIN_VERSION}"
    exit
}

print_help() {
    echo "usage: $0 [-v] [--namespace[=]<value>]" >&2
    echo "" >&2
    echo "-n[--namespace]     Filter by namespace" >&2
    echo "-l[--selector]      Filter by node label" >&2
    echo "-o[--output]        Output [text/json] default text" >&2
    echo "-h                  Human readable" >&2
    echo "--context           The name of the kubeconfig context to use" >&2
    echo "--no-headers        Disable printing headers" >&2
    echo "-v                  Prints version" >&2
    echo "--help              Prints help" >&2
    echo "subcommands:" >&2
    echo "    namespace[s]    Shows namespace utilization" >&2
    echo "    node[s]         Shows node utilization" >&2
    exit
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        namespace*) VIEW_UTILIZATION_SUBCOMMAND="namespaces"; shift;;
        node*) VIEW_UTILIZATION_SUBCOMMAND="nodes"; shift;;
        -n|--namespace)
            if [[ $# -lt 2 ]]; then
                echo "Namespace name is required"
                exit 1
            fi
            VIEW_UTILIZATION_NAMESPACE="$2";
            shift 2
            ;;
        -l|--selector)
            if [[ $# -lt 2 ]]; then
                echo "Label selector value is required"
                exit 1
            fi
            VIEW_UTILIZATION_NODE_LABEL="$2";
            shift 2
            ;;
        -o|--output)
            if [ "${2}" == "text" ] || [ "${2}" == "json" ]; then
                VIEW_UTILIZATION_OUTPUT="$2";
            else
                echo "Output value is required. Valid values are: text, json."
                exit 1
            fi
            shift 2
            ;;
        --context)
            if [[ $# -lt 2 ]]; then
                echo "The name of kubeconfig context name is required"
                exit 1
            fi
            VIEW_UTILIZATION_CONTEXT="${2}";
            test_kubectl_context
            shift 2
            ;;
        --context=*)
            if [ "${1#*=}" == "" ]; then
                echo "The name of kubeconfig context name is required"
                exit 1
            fi
            VIEW_UTILIZATION_CONTEXT="${1#*=}";
            test_kubectl_context
            shift 1
            ;;
        -h)
            VIEW_UTILIZATION_UNITS="human";
            shift
            ;;
        -v)
            print_plugin_version
            ;;
        --namespace=*)
            if [ "${1#*=}" == "" ]; then
                echo "Namespace name is required"
                exit 1
            fi
            VIEW_UTILIZATION_NAMESPACE="${1#*=}";
            shift 1
            ;;
        --selector=*)
            if [ "${1#*=}" == "" ]; then
                echo "Label selector value is required"
                exit 1
            fi
            VIEW_UTILIZATION_NODE_LABEL="${1#*=}";
            shift 1
            ;;
        --output=*)
            if [ "${1#*=}" == "text" ] || [ "${1#*=}" == "json" ]; then
                VIEW_UTILIZATION_OUTPUT="${1#*=}";
            else
                echo "Output value is required. Valid values are: text, json."
                exit 1
            fi
            shift 1
            ;;
        --no-headers)
            VIEW_UTILIZATION_HEADERS="false";
            shift 1
            ;;
        --help)
            print_help
            ;;
        -*)
            echo "Unknown option: $1" >&2;
            exit 1
            ;;
        *)
            echo "Unknown argument: $1" >&2;
            exit 1
            ;;
    esac
done

echo "test 2" | while read line ; do (echo $line | awk '{print $1}'); done
