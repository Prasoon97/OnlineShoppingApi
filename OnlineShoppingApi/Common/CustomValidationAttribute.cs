using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;

namespace OnlineShoppingApi.Common
{
    public class IsLessThanOrEqualsValidationAttribute : ValidationAttribute
    {
        private readonly string _dependendProperty;
        public IsLessThanOrEqualsValidationAttribute(string dependentPropertyName)
        {
            _dependendProperty = dependentPropertyName;
        }

        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            var propertyInfo = validationContext.ObjectType.GetProperty(_dependendProperty);
            if (_dependendProperty == null)
            {
                return new ValidationResult(string.Format("unknown property {0}", _dependendProperty));

            }
            var dependentPropertyValue = propertyInfo.GetValue(validationContext.ObjectInstance, null);
            if (value == null)
            {
                return ValidationResult.Success;
            }
            else if (dependentPropertyValue == null)
            {
                return ValidationResult.Success;
            }
            else if ((int)value <= (int)dependentPropertyValue)
            {
                return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
            }
        }
    }



    public class IsGreaterThanOrEqualsValidationAttribute : ValidationAttribute
    {
        private readonly string _dependendProperty;
        public IsGreaterThanOrEqualsValidationAttribute(string dependentPropertyName)
        {
            _dependendProperty = dependentPropertyName;
        }

        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            var propertyInfo = validationContext.ObjectType.GetProperty(_dependendProperty);
            if (_dependendProperty == null)
            {
                return new ValidationResult(string.Format("unknown property {0}", _dependendProperty));

            }
            var dependentPropertyValue = propertyInfo.GetValue(validationContext.ObjectInstance, null);
            if (value == null)
            {
                return ValidationResult.Success;
            }
            else if (dependentPropertyValue == null)
            {
                return ValidationResult.Success;
            }
            else if ((int)value >= (int)dependentPropertyValue)
            {
                return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
            }
        }
    }


}