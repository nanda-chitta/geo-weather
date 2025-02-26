const CustomButton = ({title, containerStyles, iconRight, type, onClick}: any) => {
  return(
    <button
      type={type || 'button'}
      className={`flex items-center justify-center gap-2 ${containerStyles}`}
      onClick={onClick}
    >
      {title}

      { iconRight && (
        <div className="text-ascent-1 text-sm ml-2">{iconRight}</div>
      )}
    </button>
  );
}

export default CustomButton;
